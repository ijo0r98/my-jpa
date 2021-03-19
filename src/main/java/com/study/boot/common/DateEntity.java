package com.study.boot.common;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@Setter
@MappedSuperclass
public abstract class DateEntity {

    @CreatedDate
    private LocalDateTime regDate;

    @LastModifiedDate
    private LocalDateTime updateDate;

}