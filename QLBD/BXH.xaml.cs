﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace QLBD
{
    /// <summary>
    /// Interaction logic for BXH.xaml
    /// </summary>
    public partial class BXH : UserControl
    {
        public BXH()
        {
            InitializeComponent();
            dpDateSelection.SelectedDate = DateTime.Now;
        }

        private void dpDateSelection_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
