# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.azurerm_log_analytics_workspace_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_storage_account" "es_config" {
  name                = "${local.azurerm_storage_account_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

# New resources

resource "azurerm_container_group" "forum_container_group" {
  name                = "${local.azurerm_container_group_name}"
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  ip_address_type     = "public"
  dns_name_label      = "elastic-search"
  os_type             = "Linux"

  container {
    name                  = "elastic-search"
    image                 = "docker.elastic.co/elasticsearch/elasticsearch:6.8.4"
    cpu                   = "2"
    memory                = "4"

    environment_variables = {
      ES_JAVA_OPTS = "-Xms512m -Xmx4g"
    }

    volume {
      name                 = "es-config"
      mount_path           = "/usr/share/elasticsearch/config"
      read_only            = true
      storage_account_name = "${data.azurerm_storage_account.es_config.name}"
      storage_account_key  = "${data.azurerm_storage_account.es_config.primary_access_key}"
      share_name           = "${local.azurerm_storage_share_name}"
    }

    ports {
      port     = 9200
      protocol = "TCP"
    }

    ports {
      port     = 9300
      protocol = "TCP"
    }
  }

  container {
    name     = "crawler"
    image    = "italia/publiccode-tools-crawler"
    cpu      = "2"
    memory   = "1"

    commands = ["./wait-for-it.sh", "localhost:9200", "-t","300", "--", "./start.sh"]
  }

  diagnostics {
    log_analytics {
      log_type      = "ContainerInsights"
      workspace_id  = "${data.azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id}"
      workspace_key = "${data.azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key}"
    }
  }

  tags = {
    environment = "${var.environment}"
  }
}
