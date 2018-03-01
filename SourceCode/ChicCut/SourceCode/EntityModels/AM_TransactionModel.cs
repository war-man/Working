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
    
    public partial class AM_TransactionModel
    {
        public int TransactionId { get; set; }
        public Nullable<int> StoreId { get; set; }
        public Nullable<int> AMAccountId { get; set; }
        public string TransactionTypeCode { get; set; }
        public string ContactItemTypeCode { get; set; }
        public Nullable<int> CustomerId { get; set; }
        public Nullable<int> SupplierId { get; set; }
        public Nullable<int> EmployeeId { get; set; }
        public Nullable<int> OtherId { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public Nullable<int> OrderId { get; set; }
        public Nullable<int> ImportMasterId { get; set; }
        public Nullable<int> IEOtherMasterId { get; set; }
        public string Note { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public Nullable<int> CreateEmpId { get; set; }
        public string Address { get; set; }
        public Nullable<decimal> RemainingAmountAccrued { get; set; }
    
        public virtual AM_AccountModel AM_AccountModel { get; set; }
        public virtual AM_ContactItemTypeModel AM_ContactItemTypeModel { get; set; }
        public virtual AM_TransactionTypeModel AM_TransactionTypeModel { get; set; }
        public virtual StoreModel StoreModel { get; set; }
    }
}