package ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot};

import lombok.Getter;
import lombok.Setter;
<#list generateInfo.importList as import>
import ${import};
</#list>
import com.alibaba.fastjson2.JSONArray;

/**
 * ${generateInfo.tableComment}详情
 *
 * @author ${generateInfo.author}
 * @date ${generateInfo.date}
 **/
@Getter
@Setter
public class ${generateInfo.moduleName}Detail {

<#list generateInfo.columnList as column>
    <#if "${column.columnCamelName}"?matches("deleted|mctNo")>
    <#else>
    /** ${column.columnComment} */
    private ${column.columnJavaTypeName} ${column.columnCamelName};

    </#if>
</#list>
}
