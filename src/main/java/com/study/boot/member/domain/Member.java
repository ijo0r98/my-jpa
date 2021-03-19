package com.study.boot.member.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.study.boot.board.domain.Board;
import com.study.boot.board.domain.Comment;
import com.study.boot.common.DateEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Entity
@Setter
@Getter
@Table(name = "member", uniqueConstraints = {
        @UniqueConstraint(columnNames = "memberId")
})
@NoArgsConstructor
@AllArgsConstructor
public class Member extends DateEntity implements UserDetails  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberNo;

    @JsonBackReference
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Board> boards = new ArrayList<>();

    @JsonBackReference
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    @Column(length = 100, nullable = false)
    private String memberId;

    @Column(length = 1000, nullable = false)
    private String memberPw;

    @Column(length = 50, nullable = false)
    private String memberNm;

    @Column(length = 30)
    private String memberTell;

    @Column(length = 100, nullable = false)
    private String memberEmail;

    @Column(insertable = false, columnDefinition = "char(1) default 'Y'")
    private String memberYn;

    @Column
    @Enumerated(EnumType.STRING)
    private Role memberRole;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(this.memberRole.toString()));
    }

    @Override
    public String getPassword() {
        return this.memberPw;
    }

    @Override
    public String getUsername() {
        return this.memberNm;
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        if (this.memberYn.equals("Y")) {
            return true;
        } else {
            return false;
        }
    }

}
