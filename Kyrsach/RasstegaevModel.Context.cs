﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class TeatrEntities : DbContext
    {
        public static TeatrEntities _context;

        public static TeatrEntities GetContext()
        {
            if (_context == null)
            {
                _context = new TeatrEntities();
            }

            return _context;
        }
        public TeatrEntities()
            : base("name=TeatrEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Employees_of_the_teatr> Employees_of_the_teatrs { get; set; }
        public virtual DbSet<Performance> Performances { get; set; }
        public virtual DbSet<Tour> Tours { get; set; }
        public virtual DbSet<Troupe> Troupes { get; set; }
        public virtual DbSet<RepertoireTeatra> RepertoireTeatras { get; set; }
    }
}