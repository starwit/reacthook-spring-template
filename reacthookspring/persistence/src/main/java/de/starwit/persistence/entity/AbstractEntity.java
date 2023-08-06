package de.starwit.persistence.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class AbstractEntity<PK extends Serializable> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    protected PK id;

    /**
     *
     */
    public AbstractEntity() {
        super();
    }

    /**
     * @return
     */
    public PK getId() {
        return this.id;
    }

    public void setId(PK id) {
        this.id = id;
    }

}
