using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
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

namespace Kyrsach
{
    /// <summary>
    /// Логика взаимодействия для SotrudnikPage.xaml
    /// </summary>
    public partial class SotrudnikPage : Page
    {
        int CountInPage = 10;
        int CountRecords;
        int CountPage;
        int CurrentPage = 0;

        List<Employees_of_the_teatr> CurrentPageList = new List<Employees_of_the_teatr>();
        List<Employees_of_the_teatr> TableList;
        public SotrudnikPage()
        {
            InitializeComponent();

            List<Employees_of_the_teatr> currentClients = TeatrEntities.GetContext().Employees_of_the_teatrs.ToList();

            TeatrListView.ItemsSource = currentClients;
            FiltrBox.SelectedIndex = 0;
            strCount.SelectedIndex = 0;
            SortBox.SelectedIndex = 0;
            TBAllRecords.Text = TeatrEntities.GetContext().Employees_of_the_teatrs.ToList().Count().ToString();
            Update();
        }
        public void Update()
        {
            // Получение всех сотрудников театра
            var currentClient = TeatrEntities.GetContext().Employees_of_the_teatrs.ToList();

            // Проверка на наличие данных
            if (currentClient == null || currentClient.Count == 0)
            {
                MessageBox.Show("Нет данных для отображения.");
                return;
            }

            // Применение фильтрации по полу
            switch (FiltrBox.SelectedIndex)
            {
                case 1: // Женский пол
                    currentClient = currentClient.Where(p => p.Gender == "ж").ToList();
                    break;
                case 2: // Мужской пол
                    currentClient = currentClient.Where(p => p.Gender == "м").ToList();
                    break;
                default: // Все
                    break;
            }

            // Применение сортировки на основе выбранного индекса
            switch (SortBox.SelectedIndex)
            {
                case 1: // Сортировка по Last_name (От А до Я)
                    currentClient = currentClient.OrderBy(p => p.Last_name).ToList();
                    break;

                case 2: // Сортировка по стажу работы (от большего к меньшему)
                    currentClient = currentClient.OrderByDescending(p => p.Experience).ToList();
                    break;

                case 3: // Сортировка по стажу работы (от меньшего к большему)
                    currentClient = currentClient.OrderBy(p => p.Experience).ToList();
                    break;

                default: // По умолчанию (без сортировки)
                    break;
            }

            // Применение фильтрации по поисковому запросу (включая должность)
            currentClient = currentClient.Where(p => (p.Last_name != null && p.Last_name.ToLower().Contains(TBoxSearch.Text.ToLower())) ||
                                                     (p.First_name != null && p.First_name.ToLower().Contains(TBoxSearch.Text.ToLower())) ||
                                                     (p.Patronymic != null && p.Patronymic.ToLower().Contains(TBoxSearch.Text.ToLower())) ||
                                                     (p.Post != null && p.Post.ToLower().Contains(TBoxSearch.Text.ToLower())) || // Поиск по должности
                                                     (p.Phone != null && p.Phone.Replace("+", "").Replace(" ", "").Replace("-", "").Replace("(", "").Replace(")", "").ToLower()
                                                                .Contains(TBoxSearch.Text.Replace("+", "").Replace(" ", "").Replace("-", "").Replace("(", "").Replace(")", "").ToLower())))

                                               .ToList();

            // Обновление текста о количестве записей
            TBAllRecords.Text = TeatrEntities.GetContext().Employees_of_the_teatrs.Count().ToString();
            TBCount.Text = currentClient.Count().ToString();

            // Обновление источника данных для ListView
            TeatrListView.ItemsSource = currentClient;
            TableList = currentClient;

            // Логика для определения количества элементов на странице
            if (strCount.SelectedIndex == 0)
            {
                CountInPage = 5;
            }
            else if (strCount.SelectedIndex == 1)
            {
                CountInPage = 10;
            }
            else if (strCount.SelectedIndex == 2)
            {
                CountInPage = 20;
            }
            else if (strCount.SelectedIndex == 3)
            {
                CountInPage = 0;
            }

            // Обновление страницы
            ChangePage(0, 0);
        }





        private void ChangePage(int direction, int? selectedPage)
        {
            CurrentPageList.Clear();
            CountRecords = TableList.Count;
            if (CountInPage != 0)
            {
                if (CountRecords % CountInPage > 0)
                {
                    CountPage = CountRecords / CountInPage + 1;
                }
                else
                {
                    CountPage = CountRecords / CountInPage;
                }

                Boolean Ifupdate = true;

                int min;

                if (selectedPage.HasValue)
                {
                    if (selectedPage >= 0 && selectedPage <= CountPage)
                    {
                        CurrentPage = (int)selectedPage;
                        min = CurrentPage * CountInPage + CountInPage < CountRecords ? CurrentPage * CountInPage + CountInPage : CountRecords;
                        for (int i = CurrentPage * CountInPage; i < min; i++)
                        {
                            CurrentPageList.Add(TableList[i]);
                        }
                    }
                }
                else
                {
                    switch (direction)
                    {
                        case 1:
                            if (CurrentPage > 0)
                            {
                                CurrentPage--;
                                min = CurrentPage * CountInPage + CountInPage < CountRecords ? CurrentPage * CountInPage + CountInPage : CountRecords;
                                for (int i = CurrentPage * CountInPage; i < min; i++)
                                {
                                    CurrentPageList.Add(TableList[i]);
                                }
                            }
                            else
                            {
                                Ifupdate = false;
                            }
                            break;
                        case 2:
                            if (CurrentPage < CountPage - 1)
                            {
                                CurrentPage++;
                                min = CurrentPage * CountInPage + CountInPage < CountRecords ? CurrentPage * CountInPage + CountInPage : CountRecords;
                                for (int i = CurrentPage * CountInPage; i < min; i++)
                                {
                                    CurrentPageList.Add(TableList[i]);
                                }
                            }
                            else
                            {
                                Ifupdate = false;
                            }
                            break;
                    }
                }
                if (Ifupdate)
                {
                    PageListBox.Items.Clear();
                    for (int i = 1; i <= CountPage; i++)
                    {
                        PageListBox.Items.Add(i);
                    }
                    PageListBox.SelectedIndex = CurrentPage;

                    //min = CurrentPage * CountInPage + CountInPage < CountRecords ? CurrentPage * CountInPage + CountInPage : CountRecords;
                    //TBCount.Text = min.ToString();
                    //TBAllRecords.Text = CountRecords.ToString();

                    TeatrListView.ItemsSource = CurrentPageList;

                    TeatrListView.Items.Refresh();
                }
            }
            else
            {
                PageListBox.Items.Clear();
                PageListBox.Items.Add(1);
            }
        }

        private void AddClient_Click(object sender, RoutedEventArgs e)
        {
            new AddEditWindow(null).ShowDialog();
            Update();
        }

        private void LeftDirButton_Click(object sender, RoutedEventArgs e)
        {
            ChangePage(1, null);
        }

        private void RightDirButton_Click(object sender, RoutedEventArgs e)
        {
            ChangePage(2, null);
        }

        private void BtnAddEdit_Click(object sender, RoutedEventArgs e)
        {
            new AddEditWindow((sender as Button).DataContext as Employees_of_the_teatr).ShowDialog();
            Update();
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var currentClient = (sender as Button).DataContext as Employees_of_the_teatr;

            if (currentClient.Experience > 3)
            {
                if (MessageBox.Show("Вы точно хотите выполнить удаление?", "Внимание!", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    TeatrEntities.GetContext().Employees_of_the_teatrs.Remove(currentClient);
                    TeatrEntities.GetContext().SaveChanges();
                    TeatrListView.ItemsSource = TeatrEntities.GetContext().Employees_of_the_teatrs.ToList();
                    Update();
                }
            }
            else
            {
                MessageBox.Show("Невозможно выполнить удаление, так как сотрудник не отработал нужный стаж в компании!");
            }
        }

        private void FiltrBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void TBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void PageListBox_MouseUp(object sender, MouseButtonEventArgs e)
        {
            ChangePage(0, Convert.ToInt32(PageListBox.SelectedItem.ToString()) -1);
        }

        private void SortBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void strCount_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
    }
}
