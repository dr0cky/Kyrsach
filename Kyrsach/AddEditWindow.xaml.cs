using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Kyrsach
{
    /// <summary>
    /// Логика взаимодействия для AddEditWindow.xaml
    /// </summary>
    public partial class AddEditWindow : Window
    {
        private Employees_of_the_teatr currentTeatr = new Employees_of_the_teatr();
        public bool check = false;

        // Конструктор с передачей объекта Employees_of_the_teatr
        public AddEditWindow(Employees_of_the_teatr employee = null)
        {
            InitializeComponent();

            if (employee != null) // Если передан объект, это редактирование
            {
                check = true;
                currentTeatr = employee;

                // Устанавливаем DataContext для привязки данных
                this.DataContext = currentTeatr;

                // Устанавливаем выбранный пол в ComboBox
                if (currentTeatr.Gender != null)
                {
                    GenderCodeBox.SelectedItem = GenderCodeBox.Items.Cast<ComboBoxItem>()
                        .FirstOrDefault(item => item.Content.ToString() == currentTeatr.Gender);
                }

                // Устанавливаем выбранную должность
                if (!string.IsNullOrWhiteSpace(currentTeatr.Post))
                {
                    PositionBox.SelectedValue = currentTeatr.Post;
                }

                // Устанавливаем стаж
                ExperienceBox.Text = currentTeatr.Experience.ToString();

                // Если дата не заполняется корректно
                BirthdayDate.SelectedDate = currentTeatr.Year_of_birth;
                AdmissionDate.SelectedDate = currentTeatr.Year_of_admissionWork; // Дата начала работы

                // Устанавливаем адрес и город
                AddressBox.Text = currentTeatr.Address;
                CityBox.Text = currentTeatr.City;
            }
        }

        private void ClientSave_Click(object sender, RoutedEventArgs e)
        {
            // Присваиваем значения из UI в объект currentTeatr перед валидацией
            currentTeatr.First_name = FirstNameBox.Text;
            currentTeatr.Last_name = LastNameBox.Text;
            currentTeatr.Patronymic = PatronymicBox.Text;
            currentTeatr.Phone = PhoneBox.Text;

            // Обработка изменения пола
            var selectedGender = GenderCodeBox.SelectedItem as ComboBoxItem;
            if (selectedGender != null)
            {
                currentTeatr.Gender = selectedGender.Content.ToString(); // Обновляем пол
            }

            // Обработка изменения должности
            currentTeatr.Post = PositionBox.SelectedValue.ToString(); // Получаем выбранную должность

            // Обработка стажа
            if (int.TryParse(ExperienceBox.Text, out int experience))
            {
                currentTeatr.Experience = experience; // Присваиваем стаж
            }
            else
            {
                currentTeatr.Experience = 0; // Если стаж не введен, то устанавливаем в 0
            }

            // Обработка даты начала работы
            if (AdmissionDate.SelectedDate.HasValue)
            {
                currentTeatr.Year_of_admissionWork = AdmissionDate.SelectedDate.Value;
            }

            // Обработка адреса и города
            currentTeatr.Address = AddressBox.Text;
            currentTeatr.City = CityBox.Text;

            // Валидация данных
            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrWhiteSpace(currentTeatr.Post))
                errors.AppendLine("Укажите должность!");

            if (BirthdayDate.SelectedDate == null)
            {
                errors.AppendLine("Укажите корректную дату рождения!");
            }
            else
            {
                currentTeatr.Year_of_birth = BirthdayDate.SelectedDate.Value;
            }

            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            // Проверка на дублирование сотрудника
            List<Employees_of_the_teatr> allClient = TeatrEntities.GetContext().Employees_of_the_teatrs.ToList();
            var existingClients = allClient.Where(p =>
                p.Last_name == currentTeatr.Last_name &&
                p.First_name == currentTeatr.First_name &&
                p.Patronymic == currentTeatr.Patronymic &&
                p.Phone == currentTeatr.Phone &&
                p.Worker_ID != currentTeatr.Worker_ID // Исключаем текущего сотрудника
            ).ToList();

            if (existingClients.Count == 0)
            {
                if (check == false) // Если это новый работник
                {
                    currentTeatr.Year_of_admissionWork = DateTime.Now;
                }

                if (currentTeatr.Worker_ID == 0)
                {
                    TeatrEntities.GetContext().Employees_of_the_teatrs.Add(currentTeatr);
                }

                try
                {
                    TeatrEntities.GetContext().SaveChanges();
                    MessageBox.Show("Информация сохранена");
                    this.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка сохранения данных: {ex.Message}");
                }
            }
            else
            {
                MessageBox.Show("Такой сотрудник уже существует");
            }
        }



        private void LastNameBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void PatronymicBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void PhoneBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void ExperienceBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}