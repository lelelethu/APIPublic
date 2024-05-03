using Microsoft.AspNetCore.Http;

namespace TXAPI.Models.File
{
	public class FileUploadModel
    {
        public IFormFile FileDetails { get; set; }
        public FileType FileType { get; set; }
    }
}
