---
layout: notes
---

# Azure Data Lake Storage gen 2

## Directories and files listing from C#

To summarize: ADLS gen 2 is a Blob Storage on steroids. To list files, we should use Azure.Storage.Files.DataLake. If we insist on using Azure.Storage.Blobs, we loose hierarchy and some strange blobs appear on the road. 

There are 2 ways to connect to ADLS: using the account name + account key or a SAS url. I strongly suggest the latter for security reasons.

Parameters for account name + key:
```csharp
string storageAccountName = "storagename";  
string stroageAccountKey = "Q6EQt....==";  
string storageContainerName = "testcontainer";
string storageAccountURL = $"https://{storageAccountName}.dfs.core.windows.net";    
// even "https://{storageAccountName}.blob.core.windows.net" works fine
```

Parameters for SAS url:
```csharp
string storageAccountSASUrl = "https://storagename.blob.core.windows.net/testcontainer?sp=racwdlmeop&st=...&spr=https&...sr=c&sig=leA....";
```

### Listing files and directories using DataLake client

Code:

```csharp                
var dataLakeCredential = new StorageSharedKeyCredential(storageAccountName, troageAccountKey);
var dataLakeClient = new DataLakeServiceClient(new Uri(storageAccountURL), ataLakeCredential);
var dataLakeFileSystem = dataLakeClient.GetFileSystemClient(storageContainerName);
var items = dataLakeFileSystem.GetPaths(recursive: true).ToList();
foreach (var item in items)
{
    Console.WriteLine($" > {(item.IsDirectory == true ? "[DIR]" : "     ")} {item.Name}");
}
```

Output:

```
 > [DIR] d1
 > [DIR] d1/d1_1
 >       d1/d1_1/file8.jpg
 >       d1/d1_1/file9.jpg
 >       d1/file3.jpg
 >       d1/file4.jpg
 >       d1/file5.jpg
 > [DIR] d_empty
 >       file1.jpg
 >       file2.jpg
```

### List files and directories using DataLake client on a SAS Url

Code:

```csharp 
var dataLakeFSClient = new DataLakeFileSystemClient(new Uri(storageAccountSASUrl));
var items = dataLakeFSClient.GetPaths(recursive: true).ToList();
foreach (var item in items)
{
    Console.WriteLine($" > {(item.IsDirectory == true ? "[DIR]" : "     ")} {item.Name}");
}
```

Output:

```
 > [DIR] d1
 > [DIR] d1/d1_1
 >       d1/d1_1/file8.jpg
 >       d1/d1_1/file9.jpg
 >       d1/file3.jpg
 >       d1/file4.jpg
 >       d1/file5.jpg
 > [DIR] d_empty
 >       file1.jpg
 >       file2.jpg
```

### List files and directories using traditional Blob client on a SAS Url

Code:

```csharp 
var blobClient = new BlobContainerClient(new Uri(storageAccountSASUrl));
var blobs = blobClient.GetBlobs(traits: Azure.Storage.Blobs.Models.BlobTraits.Metadata).ToList();
foreach (var blob in blobs)
{                    
    bool isFolder = blob.Metadata.ContainsKey("hdi_isfolder");   // when key is present, the value is always true"
    Console.WriteLine($" > {(isFolder == true ? "[DIR]" : "     ")} {blob.Name}");
}
```

Output:

```
 > [DIR] d1
 > [DIR] d1/d1_1
 >       d1/d1_1/file8.jpg
 >       d1/d1_1/file9.jpg
 >       d1/file3.jpg
 >       d1/file4.jpg
 >       d1/file5.jpg
 > [DIR] d_empty
 >       file1.jpg
 >       file2.jpg
```
