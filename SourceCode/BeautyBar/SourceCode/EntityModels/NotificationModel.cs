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
    
    public partial class NotificationModel
    {
        public int NotificationId { get; set; }
        public string Note { get; set; }
        public Nullable<int> AccountId { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public bool Actived { get; set; }
        public string NotifiType { get; set; }
        public Nullable<System.DateTime> EffectDate { get; set; }
    }
}