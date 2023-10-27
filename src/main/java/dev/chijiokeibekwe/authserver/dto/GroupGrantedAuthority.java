package dev.chijiokeibekwe.authserver.dto;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;

@NoArgsConstructor
@AllArgsConstructor
@JsonDeserialize
public class GroupGrantedAuthority implements GrantedAuthority {
    private String groupName;
    private String authority;

    @Override
    public String getAuthority() {
        return authority;
    }

    public String getGroupName() {
        return groupName;
    }
}
