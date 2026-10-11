# Version comparison helpers used by build/tasks/kernel.mk and config/BoardConfigKernel.mk.
# Copied unchanged from vendor/infinity (LineageOS) build/core/utils.mk.
# Only these two functions are kept, to avoid redefining the board-platform helpers
# that Qualcomm's device/qcom/common already provides.
# They rely on math_gt, math_gt_or_eq, math_lt and math_lt_or_eq from AOSP build/make/core/math.mk.

# $(call is-version-greater-or-equal,version_a,version_b)
# version_a >= version_b
define is-version-greater-or-equal
$(strip \
  $(eval a_major := $(word 1,$(subst ., ,$(1)))) \
  $(eval a_minor := $(word 2,$(subst ., ,$(1)))) \
  $(eval b_major := $(word 1,$(subst ., ,$(2)))) \
  $(eval b_minor := $(word 2,$(subst ., ,$(2)))) \
  $(if $(call math_gt,$(a_major),$(b_major)),true, \
    $(if $(call math_gt_or_eq,$(a_major),$(b_major)), \
      $(if $(call math_gt_or_eq,$(a_minor),$(b_minor)),true,false), \
    false)) \
)
endef

# $(call is-version-lower-or-equal,version_a,version_b)
# version_a <= version_b
define is-version-lower-or-equal
$(strip \
  $(eval a_major := $(word 1,$(subst ., ,$(1)))) \
  $(eval a_minor := $(word 2,$(subst ., ,$(1)))) \
  $(eval b_major := $(word 1,$(subst ., ,$(2)))) \
  $(eval b_minor := $(word 2,$(subst ., ,$(2)))) \
  $(if $(call math_lt,$(a_major),$(b_major)),true, \
    $(if $(call math_lt_or_eq,$(a_major),$(b_major)), \
      $(if $(call math_lt_or_eq,$(a_minor),$(b_minor)),true,false), \
    false)) \
)
endef
