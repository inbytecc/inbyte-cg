package ${generateInfo.controllerPackage};

import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.alibaba.fastjson2.JSON;
import org.hamcrest.core.Is;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import ${basicConfig.groupId}.test.TestConstant;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Query;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Create;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Update;

/**
* ${generateInfo.tableComment}
*
* @author ${generateInfo.author}
* @date ${generateInfo.date}
**/
@SpringBootTest
@AutoConfigureMockMvc
public class ${generateInfo.moduleName}Test {

    @Autowired
    private MockMvc mockMvc;

    /**
     * 创建测试
     **/
    @Test
    public void createTest() throws Exception {
        ${generateInfo.moduleName}Create create = new ${generateInfo.moduleName}Create();
        <#list generateInfo.columnList as column>
            <#if generateInfo.primaryKey == column.columnCamelName || "${column.columnCamelName}"?matches("deleted|isDel|isDelete|isDeleted|createUserName|createUserId|createTime|updateUserName|updateUserId|updateTime")>
            <#else>
            <#if column.columnJavaTypeName == 'String'>
                create.${column.setterName}("1");
            <#elseIf column.columnJavaTypeName == 'Integer'>
                create.${column.setterName}(1);
            <#elseIf column.columnJavaTypeName == 'BigDecimal'>
                create.${column.setterName}(BigDecimal.valueOf(0.01));
            <#elseIf column.columnJavaTypeName == 'LocalDateTime'>
                create.${column.setterName}(LocalDateTime.now());
            <#else>
                create.${column.setterName}("1");
            </#if>
            </#if>
        </#list>
        String jsonRequest = JSON.toJSONString(create);

        ResultActions resultActions = this.mockMvc.perform(MockMvcRequestBuilders.post("/weixin/official/account/config")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", TestConstant.Authorization)
                .content(jsonRequest));

        resultActions.andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.status", Is.is(200)));
    }

    /**
     * 更新测试
     **/
    @Test
    public void updateTest() throws Exception {
        ${generateInfo.moduleName}Update update = new ${generateInfo.moduleName}Update();
        <#list generateInfo.columnList as column>
            <#if "${column.columnCamelName}"?matches("deleted|isDel|isDelete|isDeleted|createUserName|createUserId|createTime|updateUserName|updateUserId|updateTime")>
            <#else>
            <#if column.columnJavaTypeName == 'String'>
                update.${column.setterName}("1");
            <#elseIf column.columnJavaTypeName == 'Integer'>
                update.${column.setterName}(1);
            <#elseIf column.columnJavaTypeName == 'BigDecimal'>
                update.${column.setterName}(BigDecimal.valueOf(0.01));
            <#elseIf column.columnJavaTypeName == 'LocalDateTime'>
                update.${column.setterName}(LocalDateTime.now());
            <#else>
                update.${column.setterName}("1");
            </#if>
            </#if>
        </#list>
        String jsonRequest = JSON.toJSONString(update);

        ResultActions resultActions = this.mockMvc.perform(MockMvcRequestBuilders.put("/weixin/official/account/config")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", TestConstant.Authorization)
                .content(jsonRequest));

        resultActions.andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.status", Is.is(200)));

    }

    /**
     * 详情测试
     **/
    @Test
    public void detailTest() throws Exception {
        ResultActions resultActions = this.mockMvc.perform(MockMvcRequestBuilders.get("/weixin/official/account/config/{generateInfo.primaryKey}", 1)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", TestConstant.Authorization));

        resultActions.andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.status", Is.is(200)));
    }

    /**
     * 列表测试
     **/
    @Test
    public void list() throws Exception {
        ${generateInfo.moduleName}Query query = new ${generateInfo.moduleName}Query();

        ResultActions resultActions = this.mockMvc.perform(MockMvcRequestBuilders.get("/weixin/official/account/config", query)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", TestConstant.Authorization)
        );

        resultActions.andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.status", Is.is(200)));
    }
}