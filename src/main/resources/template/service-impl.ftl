package ${generateInfo.servicePackage}.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.inbyte.commons.model.dto.Page;
import com.inbyte.commons.model.dto.R;
import com.inbyte.commons.util.PageUtil;
import com.inbyte.component.admin.system.user.SessionUtil;
import ${generateInfo.servicePackage}.${generateInfo.moduleName}Service;
import ${generateInfo.mapperPackage}.${generateInfo.moduleName}Mapper;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Po;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Query;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Create;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Update;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Brief;
import ${generateInfo.modelPackage}.${generateInfo.moduleNameWithDot}.${generateInfo.moduleName}Detail;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

/**
 * ${generateInfo.tableComment}服务
 *
 * @author ${generateInfo.author}
 * @date ${generateInfo.date}
 **/
@Service
public class ${generateInfo.moduleName}ServiceImpl implements ${generateInfo.moduleName}Service {

    @Autowired
    private ${generateInfo.moduleName}Mapper ${generateInfo.moduleNameLowercaseCamel}Mapper;

    @Override
    public R create(${generateInfo.moduleName}Create create) {
        ${generateInfo.moduleName}Po ${generateInfo.moduleNameLowercaseCamel}Po = ${generateInfo.moduleName}Po.builder()
                .mctNo(SessionUtil.getMctNo())
                .createTime(LocalDateTime.now())
                .creator(SessionUtil.getUserName())
                .build();
        BeanUtils.copyProperties(create, ${generateInfo.moduleNameLowercaseCamel}Po);
        ${generateInfo.moduleNameLowercaseCamel}Mapper.insert(${generateInfo.moduleNameLowercaseCamel}Po);
        return R.ok("创建成功");
    }

    @Override
    public R delete(${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel}) {
        LambdaQueryWrapper<${generateInfo.moduleName}Po> queryWrapper = new LambdaQueryWrapper<${generateInfo.moduleName}Po>()
            .eq(${generateInfo.moduleName}Po::get${generateInfo.primaryKeyUpperCamel}, ${generateInfo.primaryKeyLowerCamel})
            .eq(${generateInfo.moduleName}Po::getMctNo, SessionUtil.getMctNo());
        ${generateInfo.moduleNameLowercaseCamel}Mapper.delete(queryWrapper);
        return R.ok("删除成功");
    }

    @Override
    public R update(${generateInfo.moduleName}Update update) {
        ${generateInfo.moduleName}Po ${generateInfo.moduleNameLowercaseCamel}Po = ${generateInfo.moduleName}Po.builder()
                .updateTime(LocalDateTime.now())
                .modifier(SessionUtil.getUserName())
                .build();
        BeanUtils.copyProperties(update, ${generateInfo.moduleNameLowercaseCamel}Po);

        LambdaQueryWrapper<${generateInfo.moduleName}Po> queryWrapper = new LambdaQueryWrapper<${generateInfo.moduleName}Po>()
                .eq(${generateInfo.moduleName}Po::get${generateInfo.primaryKeyUpperCamel}, update.get${generateInfo.primaryKeyUpperCamel}())
                .eq(${generateInfo.moduleName}Po::getMctNo, SessionUtil.getMctNo());
        ${generateInfo.moduleNameLowercaseCamel}Mapper.update(${generateInfo.moduleNameLowercaseCamel}Po, queryWrapper);
        return R.ok("修改成功");
    }

    @Override
    public R${"<"}${generateInfo.moduleName}Detail${">"} detail(${generateInfo.primaryKeyJavaTypeName} ${generateInfo.primaryKeyLowerCamel}) {
        return R.ok(${generateInfo.moduleNameLowercaseCamel}Mapper.detail(${generateInfo.primaryKeyLowerCamel}));
    }

    @Override
    public R${"<Page<"}${generateInfo.moduleName}Brief${">>"} list(${generateInfo.moduleName}Query query) {
        if (query.getEndDate() != null) {
            query.setEndDate(query.getEndDate().plusDays(1));
        }
        PageUtil.startPage(query);
        return R.page(${generateInfo.moduleNameLowercaseCamel}Mapper.list(query));
    }
}