//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EntityModels
{
    using System;
    using System.Collections.Generic;
    
    public partial class InventoryTypeModel
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public InventoryTypeModel()
        {
            this.IEOtherMasterModel = new HashSet<IEOtherMasterModel>();
            this.InventoryMasterModel = new HashSet<InventoryMasterModel>();
        }
    
        public int InventoryTypeId { get; set; }
        public string InventoryTypeCode { get; set; }
        public string InventoryTypeName { get; set; }
        public string Description { get; set; }
        public Nullable<bool> isImport { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IEOtherMasterModel> IEOtherMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InventoryMasterModel> InventoryMasterModel { get; set; }
    }
}
