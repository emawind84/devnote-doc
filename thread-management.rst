.. _thread-management:

=================
Thread Management
=================



Action
---------------------------------------------------------------------

.. note:: [NOTE Because the following runnable needs some services from spring context is defined as a bean, ready to be injected.]

.. code-block:: java
    
    @Service
    @Scope( "prototype" ) // This Runnable object has to be instanciated every time that is executed!
    public class PdfConverter implements Runnable {
        ...
        @Resource private CoreDao coreDao;
        @Resource private TemporaryFileService temporaryFileService;
        @Resource private CommonService commonService;
        ...
        
        public void run() {
            try {
                Thread.sleep(5000);
                generatePdfFromHtml();
            } catch (Exception e) {
                PmisLog.log(e);
            }
        }
    
    }
    
    
    @Service
    public class DocumentService extends CommonService {
        ...
        @Resource private TaskExecutor taskExecutor;
        @Resource private ObjectFactory pdfConverterFactory;
        
        public void doSomething() {
            // the bean lookup (instantiation) is performed every time a new task is executed
            PdfConverter pdfConverter = ((PdfConverter)pdfConverterFactory.getObject())
                .setParam1( "value1" )
                .setParam2( "value2" );
            taskExecutor.execute(pdfConverter);
        }
    }


XML
------------------------------------------------------------------------

spring-scheduler.xml:


.. code-block:: xml
    
    <bean id="taskExecutor" class="org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor">
        <property name="corePoolSize" value="5" />
        <property name="maxPoolSize" value="10" />
    </bean>
    
    <bean id="pdfConverterFactory" class="org.springframework.beans.factory.config.ObjectFactoryCreatingFactoryBean">
        <property name="targetBeanName">
            <idref bean="pdfConverter" />
        </property>
    </bean>
    

Example with simple Runnable ( not managed by spring ):

Action
----------------------------------------------------------------------------

.. code-block:: java
    
    public class SimplePdfConverter implements Runnable {
        ...
        
        public void run() {
            try {
                Thread.sleep(5000);
                generatePdfFromHtml();
            } catch (Exception e) {
                PmisLog.log(e);
            }
        }
    
    }
    
    @Service
    public class DocumentService extends CommonService {
        ...
        @Resource private TaskExecutor taskExecutor;
        
        public void doSomething() {
            PdfConverter pdfConverter = new PdfConverter();
            pdfConverter
                .setParam1( "value1" )
                .setParam2( "value2" );
            taskExecutor.execute(pdfConverter);
        }
    }

XML
-------------------------------------

only taskExecutor bean is required 
    
