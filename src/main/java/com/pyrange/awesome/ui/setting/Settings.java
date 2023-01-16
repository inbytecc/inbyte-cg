package com.pyrange.awesome.ui.setting;

import com.google.common.base.Throwables;
import com.intellij.ide.util.PropertiesComponent;
import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.ui.Messages;
import com.pyrange.awesome.PyrangeConstant;
import com.pyrange.awesome.model.BasicConfig;
import com.pyrange.awesome.util.CommonUtil;
import com.pyrange.awesome.util.MessageUtil;
import com.pyrange.awesome.util.TableUtil;
import org.apache.commons.lang.StringUtils;

import javax.swing.*;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;
import java.awt.event.*;
import java.util.List;

public class Settings extends JDialog {

    private static final Logger LOGGER = Logger.getInstance(Settings.class);

    private JPanel contentPane;
    private JButton buttonOK;
    private JButton buttonCancel;
    private JTextField textFieldHost;
    private JTextField textFieldUserName;
    private JPasswordField textFieldPassword;
    private JComboBox comboBoxDatabase;
    private JTextField textFieldAuthor;
    private JTextField textFieldGroupId;
    private JComboBox jdkComboBox;
    private JTextField resultClassReferenceTextFReield;
    private JTextField pageClassReferenceTextField;
    private JTextField basePageClassTextField;

    public Settings() {
        setContentPane(contentPane);
        setModal(true);
        getRootPane().setDefaultButton(buttonOK);
        // 设置窗口位置居中
        this.setLocationRelativeTo(null);

        BasicConfig basicConfig = getBasicConfig();
        textFieldHost.setText(basicConfig.getJdbcHost());
        textFieldUserName.setText(basicConfig.getJdbcUserName());
        textFieldPassword.setText(basicConfig.getJdbcPassword());
        textFieldAuthor.setText(basicConfig.getAuthor());
        textFieldGroupId.setText(basicConfig.getGroupId());
        comboBoxDatabase.addItem(basicConfig.getJdbcDatabase());
        comboBoxDatabase.setSelectedItem(basicConfig.getJdbcDatabase());
        jdkComboBox.addItem("8");
        jdkComboBox.addItem("11");
        jdkComboBox.addItem("17");
        jdkComboBox.setSelectedItem(basicConfig.getJdkVersion());

        resultClassReferenceTextFReield.setText(basicConfig.getResultClassReference());
        pageClassReferenceTextField.setText(basicConfig.getPageUtilClassReference());
        basePageClassTextField.setText(basicConfig.getBasePageClassReference());


        buttonOK.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onOK();
            }
        });

        buttonCancel.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        });

        // call onCancel() when cross is clicked
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        // call onCancel() on ESCAPE
        contentPane.registerKeyboardAction(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        }, KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);


        comboBoxDatabase.addPopupMenuListener(new PopupMenuListener() {
            @Override
            public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
                String jdbcHost = textFieldHost.getText();
                String jdbcUserName = textFieldUserName.getText();
                String jdbcPassword = String.valueOf(textFieldPassword.getPassword());
                if (CommonUtil.isNullOrEmpty(jdbcHost)) {
                    MessageUtil.showErrorMsg("Host:Port required");
                    return;
                }
                if (CommonUtil.isNullOrEmpty(jdbcUserName)) {
                    MessageUtil.showErrorMsg("UserName required");
                    return;
                }
                if (CommonUtil.isNullOrEmpty(jdbcPassword)) {
                    MessageUtil.showErrorMsg("Password required");
                    return;
                }
                try {
                    TableUtil tableUtil = new TableUtil(jdbcHost, jdbcUserName, jdbcPassword);
                    List<String> allDatabase = tableUtil.getAllDatabase();
                    comboBoxDatabase.removeAllItems();
                    allDatabase.forEach(databaseName -> {
                        comboBoxDatabase.addItem(databaseName);
                    });
                } catch (Exception e1) {
                    MessageUtil.showErrorMsg(Throwables.getStackTraceAsString(e1));
                    LOGGER.info(e1);
                }
            }

            @Override
            public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {

            }

            @Override
            public void popupMenuCanceled(PopupMenuEvent e) {

            }
        });
    }

    private void onOK() {
        String check = checkSettingsParam();
        if (check != null) {
            Messages.showMessageDialog(check, "tip", Messages.getInformationIcon());
            return;
        }

        PropertiesComponent propertiesComponent = PropertiesComponent.getInstance();
        propertiesComponent.setValue("Pyrange-jdbcHost", textFieldHost.getText());
        propertiesComponent.setValue("Pyrange-jdbcDatabase", (String) comboBoxDatabase.getSelectedItem());
        propertiesComponent.setValue("Pyrange-jdbcUserName", textFieldUserName.getText());
        propertiesComponent.setValue("Pyrange-jdbcPassword", String.valueOf(textFieldPassword.getPassword()));
        propertiesComponent.setValue("Pyrange-author", textFieldAuthor.getText());
        propertiesComponent.setValue("Pyrange-groupId", textFieldGroupId.getText());
        propertiesComponent.setValue("Pyrange-settingsConfigured", true);
        propertiesComponent.setValue("Pyrange-jdkVersion", jdkComboBox.getSelectedItem().toString());

        propertiesComponent.setValue("Pyrange-resultClass", resultClassReferenceTextFReield.getText());
        propertiesComponent.setValue("Pyrange-pageUtilClassReference", pageClassReferenceTextField.getText());
        propertiesComponent.setValue("Pyrange-basePageClassReference", basePageClassTextField.getText());
        
        dispose();
    }

    private void onCancel() {
        // add your code here if necessary
        dispose();
    }

    public static void main(String[] args) {
        Settings dialog = new Settings();
        dialog.pack();
        dialog.setVisible(true);
        System.exit(0);
    }


    private String checkSettingsParam() {
        if (CommonUtil.isNullOrEmpty(textFieldHost.getText())) {
            return "Host:Port required";
        }
        if (CommonUtil.isNullOrEmpty(textFieldUserName.getText())) {
            return "UserName required";
        }
        if (textFieldPassword.getPassword().length == 0) {
            return "Password required";
        }
        if (CommonUtil.isNullOrEmpty((String) comboBoxDatabase.getSelectedItem())) {
            return "Database required";
        }
        if (CommonUtil.isNullOrEmpty(textFieldAuthor.getText())) {
            return "author required";
        }
        if (CommonUtil.isNullOrEmpty(textFieldGroupId.getText())) {
            return "groupId required";
        }
        return null;
    }

    public static boolean settingsConfigured() {
        PropertiesComponent propertiesComponent = PropertiesComponent.getInstance();
        return propertiesComponent.getBoolean("Pyrange-settingsConfigured");
    }

    public static BasicConfig getBasicConfig() {
        PropertiesComponent propertiesComponent = PropertiesComponent.getInstance();
        BasicConfig basicConfig = new BasicConfig();
        basicConfig.setJdbcHost(propertiesComponent.getValue("Pyrange-jdbcHost"));
        basicConfig.setJdbcDatabase(propertiesComponent.getValue("Pyrange-jdbcDatabase"));
        basicConfig.setJdbcUserName(propertiesComponent.getValue("Pyrange-jdbcUserName"));
        basicConfig.setJdbcPassword(propertiesComponent.getValue("Pyrange-jdbcPassword"));
        String groupId = StringUtils.isEmpty(propertiesComponent.getValue("Pyrange-groupId")) ? PyrangeConstant.DEFAULT_GROUP_ID : propertiesComponent.getValue("Pyrange-groupId");
        basicConfig.setGroupId(groupId);
        basicConfig.setAuthor(propertiesComponent.getValue("Pyrange-author"));
        basicConfig.setJdkVersion(propertiesComponent.getInt("Pyrange-jdkVersion", 11));

        String resultClassReference = propertiesComponent.getValue("Pyrange-resultClass");
        if (StringUtils.isEmpty(resultClassReference)) {
            resultClassReference = "com.pyrange.common.model.dto.Result";
        }
        basicConfig.setResultClassReference(resultClassReference);
        basicConfig.setResultClassName(resultClassReference.substring(resultClassReference.lastIndexOf(".")  + 1));

        String pageUtilClassReference = propertiesComponent.getValue("Pyrange-pageUtilClassReference");
        if (StringUtils.isEmpty(pageUtilClassReference)) {
            pageUtilClassReference = "com.github.pagehelper.PageHelper";
        }
        basicConfig.setPageClassUtilReference(pageUtilClassReference);
        basicConfig.setPageUtilClassName(pageUtilClassReference.substring(pageUtilClassReference.lastIndexOf(".") + 1));

        String basePageClassReference = propertiesComponent.getValue("Pyrange-basePageClassReference");
        if (StringUtils.isEmpty(basePageClassReference)) {
            basePageClassReference = "com.pyrange.common.model.dto.BasePage";
        }
        basicConfig.setBasePageClassReference(basePageClassReference);
        basicConfig.setBasePageClassName(basePageClassReference.substring(basePageClassReference.lastIndexOf(".")  + 1));

        return basicConfig;
    }


}
