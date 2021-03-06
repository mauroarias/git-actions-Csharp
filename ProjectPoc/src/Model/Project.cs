using GenesisMock.Model;

namespace ProjectPoc.Model;

public record Project
{
    public Guid? id { get; set; } = null;
    public Guid licenseId { get; set; }
    public string name { get; set; }
    public string description { get; set; }
    public DateTime created { get; set; }
    public string? licenseName { get; set; }
    public string? licenseEmail { get; set; }
    public DateTime? licenseExpiresAt { get; set; }
}