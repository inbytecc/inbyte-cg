package ${generateInfo.controllerPackage};
import com.inbyte.commons.model.dto.Page;
import com.inbyte.commons.model.dto.R;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Query;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Create;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Update;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Brief;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Detail;
import ${generateInfo.servicePackage}.${generateInfo.moduleName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

<#if basicConfig.jdkVersion == 17>
import jakarta.validation.Valid;
<#else>
import javax.validation.Valid;
</#if>
import java.util.List;

/**
 * ${generateInfo.tableComment}
 *
 * @author ${generateInfo.author}
 * @date ${generateInfo.date}
 **/
@RestController
@RequestMapping("${generateInfo.moduleNameWithSlash}")
public class ${generateInfo.moduleName}Controller {

    @Autowired
    private ${generateInfo.moduleName}Service ${generateInfo.moduleNameLowercaseCamel}Service;

    /**
     * 创建
     *
     * @param create
     * @return R
     **/
    @PostMapping
    public R create(@RequestBody @Valid ${generateInfo.moduleName}Create create) {
        return ${generateInfo.moduleNameLowercaseCamel}Service.create(create);
    }

    /**
     * 删除
     *
     * @param ${generateInfo.primaryKeyLowerCamel}
     * @return R
     **/
    @DeleteMapping("{${generateInfo.primaryKeyLowerCamel}}")
    public R delete(@PathVariable("${generateInfo.primaryKeyLowerCamel}") ${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel}) {
        return ${generateInfo.moduleNameLowercaseCamel}Service.delete(${generateInfo.primaryKeyLowerCamel});
    }

    /**
     * 更新
     *
     * @param update
     * @return R
     **/
    @PutMapping
    public R update(@RequestBody @Valid ${generateInfo.moduleName}Update update) {
        return ${generateInfo.moduleNameLowercaseCamel}Service.update(update);
    }

    /**
     * 详情
     *
     * @param ${generateInfo.primaryKeyLowerCamel}
     * @return R${"<"}${generateInfo.moduleName}Detail${">"}
     **/
    @GetMapping("{${generateInfo.primaryKeyLowerCamel}}")
    public R${"<"}${generateInfo.moduleName}Detail${">"} detail(@PathVariable("${generateInfo.primaryKeyLowerCamel}") ${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel}) {
        return ${generateInfo.moduleNameLowercaseCamel}Service.detail(${generateInfo.primaryKeyLowerCamel});
    }

    /**
     * 列表
     *
     * @param query
     * @return R${"<Page<"}${generateInfo.moduleName}Brief${">>"}
     **/
    @GetMapping
    public R${"<Page<"}${generateInfo.moduleName}Brief${">>"} list(@ModelAttribute @Valid ${generateInfo.moduleName}Query query) {
        return ${generateInfo.moduleNameLowercaseCamel}Service.list(query);
    }
}