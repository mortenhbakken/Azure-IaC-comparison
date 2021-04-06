using System.Threading.Tasks;
using Pulumi;
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Authorization;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;
using Pulumi.AzureNative.Web;
using Pulumi.AzureNative.Web.Inputs;

class MyStack : Stack
{
    public MyStack()
    {
        // Create an Azure Resource Group
        var resourceGroup = new ResourceGroup("azforumdemo-resources");

        var appServicePlan = new AppServicePlan("azforumdemo-asp", new AppServicePlanArgs
        {
            Kind = "app",
            ResourceGroupName = resourceGroup.Name,
            Sku = new SkuDescriptionArgs
            {
                Capacity = 1,
                Tier = "Basic",
                Size = "B1",
                Name = "B1"
            }
        });

        var appService = new WebApp("azforumdemo-app", new WebAppArgs
        {
            ResourceGroupName = resourceGroup.Name,
            ServerFarmId = appServicePlan.Id,
            SiteConfig = new SiteConfigArgs
            {
                AlwaysOn = true,
                NetFrameworkVersion = "v4.0",
                MinTlsVersion = SupportedTlsVersions.SupportedTlsVersions_1_2
            },
            Identity = new ManagedServiceIdentityArgs
            {
                Type = Pulumi.AzureNative.Web.ManagedServiceIdentityType.SystemAssigned
            }
        });

        // Create an Azure resource (Storage Account)
        var storageAccount = new StorageAccount("azforumdemosa", new StorageAccountArgs
        {
            ResourceGroupName = resourceGroup.Name,
            Sku = new SkuArgs
            {
                Name = SkuName.Standard_LRS
            },
            Kind = Kind.StorageV2
        });

        var container1 = new BlobContainer("container1", new BlobContainerArgs{
            ResourceGroupName = resourceGroup.Name,
            AccountName = storageAccount.Name 
        });


        var container2 = new BlobContainer("container2", new BlobContainerArgs{
            ResourceGroupName = resourceGroup.Name,
            AccountName = storageAccount.Name 
        });
    }
}
