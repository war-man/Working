﻿using EntityModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ViewModels
{
    public class OrderReturnDetailViewModel : OrderReturnDetailModel
    {
        public int STT { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
    }
}
