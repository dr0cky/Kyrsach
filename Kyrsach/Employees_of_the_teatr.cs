//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Kyrsach
{
    using System;
    using System.Collections.Generic;
    
    public partial class Employees_of_the_teatr
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Employees_of_the_teatr()
        {
            this.Troupes = new HashSet<Troupe>();
        }
    
        public int Worker_ID { get; set; }
        public string Last_name { get; set; }
        public string First_name { get; set; }
        public string Patronymic { get; set; }
        public System.DateTime Year_of_birth { get; set; }
        public System.DateTime Year_of_admissionWork { get; set; }
        public int Experience { get; set; }
        public string Post { get; set; }
        public string Gender { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Phone { get; set; }
        public string Photo { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Troupe> Troupes { get; set; }
    }
}
