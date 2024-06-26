package ${generateInfo.servicePackage};
import com.inbyte.commons.model.dto.Page;
import com.inbyte.commons.model.dto.R;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Query;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Create;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Update;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Brief;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Detail;

/**
 * ${generateInfo.tableComment}服务
 *
 * @author ${generateInfo.author}
 * @date ${generateInfo.date}
 **/
public interface ${generateInfo.moduleName}Service {

    /**
     * 创建
     *
     * @param create
     * @return R
     **/
    R create(${generateInfo.moduleName}Create create);

    /**
     * 删除
     *
     * @param ${generateInfo.primaryKeyLowerCamel}
     * @return R
     **/
    R delete(${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel});

    /**
     * 修改
     *
     * @param update
     * @return R
     **/
    R update(${generateInfo.moduleName}Update update);

    /**
     * 详情
     *
     * @param ${generateInfo.primaryKeyLowerCamel}
     * @return ${generateInfo.moduleName}Detail
     **/
    R${"<"}${generateInfo.moduleName}Detail${">"} detail(${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel});

    /**
     * 列表
     *
     * @param query
     * @return R${"<Page<"}${generateInfo.moduleName}Brief${">>"}
     **/
    R${"<Page<"}${generateInfo.moduleName}Brief${">>"} list(${generateInfo.moduleName}Query query);
}