﻿using EntityModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace ViewModels
{
    public class EmployeeInfoViewModel : EmployeeModel
    {
        [Required(ErrorMessageResourceType = typeof(Resources.LanguageResource), ErrorMessageResourceName = "Required")]
        [DataType(DataType.Password)]
        [System.Web.Mvc.Compare("Password", ErrorMessageResourceType = typeof(Resources.LanguageResource), ErrorMessageResourceName = "PasswordDoNotMatch")]
        [Display(ResourceType = typeof(Resources.LanguageResource), Name = "AccountModel_RetypePassword")]
        public string retypePassword { get; set; }

        [Display(ResourceType = typeof(Resources.LanguageResource), Name = "AccountModel_UserName")]
        [Required(ErrorMessageResourceType = typeof(Resources.LanguageResource), ErrorMessageResourceName = "Required")]
        [Remote("ValidationUserName", "Validation", AdditionalFields = "InitialUserName")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Vui lòng nhập chính xác thông tin Email.")]
        public string UserName { get; set; }

        [Display(ResourceType = typeof(Resources.LanguageResource), Name = "AccountModel_Password")]
        [Required(ErrorMessageResourceType = typeof(Resources.LanguageResource), ErrorMessageResourceName = "Required")]
        public string Password { get; set; }

        [Display(ResourceType = typeof(Resources.LanguageResource), Name = "AccountModel_RolesId")]
        public int RolesId { get; set; }
        public string RolesName { get; set; }
        public string ParentName { get; set; }

        public string InitialUserName { get { return UserName; } }



    }
}