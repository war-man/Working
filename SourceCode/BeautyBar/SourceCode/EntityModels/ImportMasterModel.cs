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
    
    public partial class ImportMasterModel
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ImportMasterModel()
        {
            this.ImportDetailModel = new HashSet<ImportDetailModel>();
        }
    
        public int ImportMasterId { get; set; }
        public string ImportMasterCode { get; set; }
        public Nullable<int> StoreId { get; set; }
        public Nullable<int> WarehouseId { get; set; }
        public Nullable<int> InventoryTypeId { get; set; }
        public Nullable<int> SupplierId { get; set; }
        public string SalemanName { get; set; }
        public string SenderName { get; set; }
        public string ReceiverName { get; set; }
        public string Note { get; set; }
        public string VATType { get; set; }
        public Nullable<decimal> VATValue { get; set; }
        public string TAXBillCode { get; set; }
        public Nullable<System.DateTime> TAXBillDate { get; set; }
        public string ManualDiscountType { get; set; }
        public Nullable<decimal> ManualDiscount { get; set; }
        public Nullable<System.DateTime> DebtDueDate { get; set; }
        public Nullable<int> CurrencyId { get; set; }
        public Nullable<decimal> ExchangeRate { get; set; }
        public Nullable<decimal> TotalPrice { get; set; }
        public Nullable<decimal> TotalQty { get; set; }
        public Nullable<decimal> TotalShippingWeight { get; set; }
        public Nullable<decimal> Paid { get; set; }
        public Nullable<decimal> MoneyTransfer { get; set; }
        public Nullable<decimal> RemainingAmount { get; set; }
        public Nullable<decimal> RemainingAmountAccrued { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string CreatedAccount { get; set; }
        public Nullable<int> CreatedEmployeeId { get; set; }
        public Nullable<System.DateTime> LastModifiedDate { get; set; }
        public string LastModifiedAccount { get; set; }
        public Nullable<int> LastModifiedEmployeeId { get; set; }
        public Nullable<System.DateTime> DeletedDate { get; set; }
        public string DeletedAccount { get; set; }
        public Nullable<int> DeletedEmployeeId { get; set; }
        public bool Actived { get; set; }
        public Nullable<decimal> SumCOGSOfOrderDetail { get; set; }
        public Nullable<decimal> SumPriceOfOrderDetail { get; set; }
        public Nullable<decimal> TotalBillDiscount { get; set; }
        public Nullable<decimal> TotalVAT { get; set; }
    
        public virtual CurrencyModel CurrencyModel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ImportDetailModel> ImportDetailModel { get; set; }
        public virtual ManualDiscountTypeModel ManualDiscountTypeModel { get; set; }
        public virtual SupplierModel SupplierModel { get; set; }
        public virtual VATTypeModel VATTypeModel { get; set; }
        public virtual WarehouseModel WarehouseModel { get; set; }
    }
}
