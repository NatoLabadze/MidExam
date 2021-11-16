package com.example.ug_javamidterm;

import javax.persistence.*;

@Entity
@Table(name = "VACANCIES")
public class Vacancy {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private long id;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "TYPE")
    private String type;

    @Column(name = "SALARY")
    private int salary;

    public Vacancy() {
    }

    public Vacancy(long id, String title, String description, String type, int salary) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.salary = salary;
    }

    public Vacancy(String title, String description, String type, int salary) {
        this.title = title;
        this.description = description;
        this.type = type;
        this.salary = salary;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    @Override
    public String toString() {
        return "Vacancy{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", type='" + type + '\'' +
                ", salary=" + salary +
                '}';
    }
}
