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
    
    public partial class InventoryDetailModel
    {
        public int InventoryDetailId { get; set; }
        public Nullable<int> InventoryMasterId { get; set; }
        public Nullable<int> ProductId { get; set; }
        public Nullable<decimal> BeginInventoryQty { get; set; }
        public Nullable<decimal> COGS { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<decimal> ImportQty { get; set; }
        public Nullable<decimal> ExportQty { get; set; }
        public Nullable<decimal> UnitCOGS { get; set; }
        public Nullable<decimal> UnitPrice { get; set; }
        public Nullable<decimal> EndInventoryQty { get; set; }
        public string Note { get; set; }
    
        public virtual InventoryMasterModel InventoryMasterModel { get; set; }
        public virtual ProductModel ProductModel { get; set; }
    }
}