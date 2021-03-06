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
    
    public partial class WarehouseModel
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public WarehouseModel()
        {
            this.IEOtherMasterModel = new HashSet<IEOtherMasterModel>();
            this.ImportMasterModel = new HashSet<ImportMasterModel>();
            this.OrderMasterModel = new HashSet<OrderMasterModel>();
            this.PreImportMasterModel = new HashSet<PreImportMasterModel>();
            this.PreOrderMasterModel = new HashSet<PreOrderMasterModel>();
            this.ProductAlertModel = new HashSet<ProductAlertModel>();
            this.ReturnMasterModel = new HashSet<ReturnMasterModel>();
        }
    
        public int WarehouseId { get; set; }
        public string WarehouseName { get; set; }
        public string Address { get; set; }
        public Nullable<int> ProvinceId { get; set; }
        public Nullable<int> DistrictId { get; set; }
        public bool Actived { get; set; }
        public Nullable<int> StoreId { get; set; }
        public string WarehouseCode { get; set; }
    
        public virtual DistrictModel DistrictModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IEOtherMasterModel> IEOtherMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ImportMasterModel> ImportMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderMasterModel> OrderMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PreImportMasterModel> PreImportMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PreOrderMasterModel> PreOrderMasterModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProductAlertModel> ProductAlertModel { get; set; }
        public virtual ProvinceModel ProvinceModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ReturnMasterModel> ReturnMasterModel { get; set; }
        public virtual StoreModel StoreModel { get; set; }
    }
}
