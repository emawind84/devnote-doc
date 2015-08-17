.. _ognl-variable-name-and-get-set-problem:

======================================
Ognl variable name and get set problem
======================================

.. note:: **This is the correct solution for OGNL over 2.7**
	
	In short: for a variable *sLocale* the correct set method is *setSLocale(...)* and not *setsLocale(...)*
	
	

.. code-block:: java
	
	public class LocaleAction extends BaseAction {
		
		private String sLocale;
		
		public String localeChange() throws Exception {
			MessageConfig.setCurrentLocale(sLocale);
			SessionUtil.getSession().setUser_locale( sLocale );
			
			if( redirect != null ) {
				return REDIRECT;
			}
			return NOTHING;
		}
	
		// WRONG for OGNL > 2.7
		// this method will not be used by ognl to set the value
		// if the variable is public will be set directly, no set method will be called
		public void setsLocale(String sLocale) {
			this.sLocale = sLocale;
		}
		
		// CORRECT for OGNL > 2.7
		// this method will be used by ognl to set the value
		// the variable should be private, in this situation the method will be called.
		// if the variable is public the method might be not called ( not tested ).
		public void setSLocale(String sLocale) {
			this.sLocale = sLocale;
		}
		
	}