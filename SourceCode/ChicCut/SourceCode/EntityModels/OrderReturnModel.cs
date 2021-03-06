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
    
    public partial class OrderReturnModel
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public OrderReturnModel()
        {
            this.OrderReturnDetailModel = new HashSet<OrderReturnDetailModel>();
        }
    
        public int OrderReturnMasterId { get; set; }
        public Nullable<int> OrderId { get; set; }
        public Nullable<int> StoreId { get; set; }
        public Nullable<int> WarehouseId { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string CreatedAccount { get; set; }
        public Nullable<int> CreatedEmployeeId { get; set; }
        public string OrderReturnMasterCode { get; set; }
        public Nullable<int> BillDiscountTypeId { get; set; }
        public Nullable<System.DateTime> DeletedDate { get; set; }
        public string DeletedAccount { get; set; }
        public Nullable<int> DeletedEmployeeId { get; set; }
        public bool Actived { get; set; }
        public Nullable<decimal> BillDiscount { get; set; }
        public Nullable<int> BillVAT { get; set; }
        public Nullable<decimal> Paid { get; set; }
        public Nullable<int> PaymentMethodId { get; set; }
        public Nullable<decimal> TotalPrice { get; set; }
        public Nullable<decimal> TotalQty { get; set; }
        public Nullable<decimal> RemainingAmount { get; set; }
        public string Note { get; set; }
        public Nullable<decimal> MoneyTransfer { get; set; }
        public Nullable<decimal> SumCOGSOfOrderDetail { get; set; }
        public Nullable<decimal> SumPriceOfOrderDetail { get; set; }
        public Nullable<decimal> TotalBillDiscount { get; set; }
        public Nullable<decimal> TotalVAT { get; set; }
        public Nullable<decimal> RemainingAmountAccrued { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderReturnDetailModel> OrderReturnDetailModel { get; set; }
    }
}
