using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.Threading.Tasks;
using TXAPI.Models.File;

namespace TXAPI.Services.FileUpload
{
	public interface IFileService
	{
		Task<IList<FileInfoModel>> Save(IFormFileCollection files, string folderPath);
		Task<byte[]> GetBinary(string filePath);
		bool Remove(string filePath);
		string ReFileName(string oldFullFileName, string newFileName);
	}
}
