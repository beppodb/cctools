#
# Rules for building various sorts of files
#

%.o: %.c
	$(CCTOOLS_CC) -o $@ -c $(CCTOOLS_INTERNAL_CCFLAGS) $(LOCAL_CCFLAGS) $<

%.o: %.cc
	$(CCTOOLS_CXX) -o $@ -c $(CCTOOLS_INTERNAL_CXXFLAGS) $(LOCAL_CXXFLAGS) $<

%.o: %.C
	$(CCTOOLS_CXX) -o $@ -c $(CCTOOLS_INTERNAL_CXXFLAGS) $(LOCAL_CXXFLAGS) $<

%.a:
	$(CCTOOLS_AR) rv $@ $^
	ranlib $@

%: %.o
	$(CCTOOLS_LD) -o $@ $(CCTOOLS_INTERNAL_LDFLAGS) $(LOCAL_LDFLAGS) $^ $(LOCAL_LINKAGE) $(CCTOOLS_EXTERNAL_LINKAGE)

%.so:
	$(CCTOOLS_LD) -o $@ -fPIC $(CCTOOLS_DYNAMIC_FLAG) $(CCTOOLS_INTERNAL_LDFLAGS) $(LOCAL_LDFLAGS) $^ $(LOCAL_LINKAGE) $(CCTOOLS_EXTERNAL_DYNLIBS)

%.$(CCTOOLS_DYNAMIC_SUFFIX):
	$(CCTOOLS_LD) -o $@ -fPIC $(CCTOOLS_DYNAMIC_FLAG) $(CCTOOLS_INTERNAL_LDFLAGS) $(LOCAL_LDFLAGS) $^ $(LOCAL_LINKAGE) $(CCTOOLS_EXTERNAL_DYNLIBS)

# Cancel Make defined implicit rule:
%: %.c
%: %.cc
%: %.C
