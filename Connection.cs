using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace AnkaraPortal.App_Code
{
    public class Connection
    {
        public static string vtb = ConfigurationManager.ConnectionStrings["AnkaraPortalConnectionString"].ConnectionString;
    }
}