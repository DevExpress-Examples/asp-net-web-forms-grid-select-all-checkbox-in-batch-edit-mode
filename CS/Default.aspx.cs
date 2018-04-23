using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

    protected void ASPxGridView1_CustomErrorText(object sender, ASPxGridViewCustomErrorTextEventArgs e)
    {
        if (e.Exception is CallbackException)
            e.ErrorText = e.Exception.Message;
    }
    protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        throw new CallbackException("Data modifications are not allowed in the online example");
    }
}

public class CallbackException : Exception
{
    public CallbackException(string message)
        : base(message)
    {
    }
}