;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[bible[=]?([a-zäëïöüæø]*)\]((([0-9][[:space:]]?)?[a-zäëïöüæø]*[[:space:]]{1}([a-zäëïöüæø]*[[:space:]]?[a-zäëïöüæø]*[[:space:]]{1})?)([0-9]{1,3})(:{1}([0-9]{1,3})(-{1}([0-9]{1,3}))?)?)\[\\/bible\]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "%[bible=\u00F6\u00E4]\u00EB\u00F6l[9[\/bible]\u00A0\\u00E3\u00A1"
(define-fun Witness1 () String (str.++ "%" (str.++ "[" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "=" (str.++ "\u{f6}" (str.++ "\u{e4}" (str.++ "]" (str.++ "\u{eb}" (str.++ "\u{f6}" (str.++ "l" (str.++ "[" (str.++ "9" (str.++ "[" (str.++ "\u{5c}" (str.++ "/" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "]" (str.++ "\u{a0}" (str.++ "\u{5c}" (str.++ "\u{e3}" (str.++ "\u{a1}" ""))))))))))))))))))))))))))))))
;witness2: "\u00E0[bible]4[wtv[9[\/bible]*"
(define-fun Witness2 () String (str.++ "\u{e0}" (str.++ "[" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "]" (str.++ "4" (str.++ "[" (str.++ "w" (str.++ "t" (str.++ "v" (str.++ "[" (str.++ "9" (str.++ "[" (str.++ "\u{5c}" (str.++ "/" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "]" (str.++ "*" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "[" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" "")))))))(re.++ (re.opt (re.range "=" "="))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e4}" "\u{e4}")(re.union (re.range "\u{e6}" "\u{e6}")(re.union (re.range "\u{eb}" "\u{eb}")(re.union (re.range "\u{ef}" "\u{ef}")(re.union (re.range "\u{f6}" "\u{f6}")(re.union (re.range "\u{f8}" "\u{f8}") (re.range "\u{fc}" "\u{fc}")))))))))(re.++ (re.range "]" "]")(re.++ (re.++ (re.++ (re.opt (re.++ (re.range "0" "9") (re.opt (re.range "[" "["))))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e4}" "\u{e4}")(re.union (re.range "\u{e6}" "\u{e6}")(re.union (re.range "\u{eb}" "\u{eb}")(re.union (re.range "\u{ef}" "\u{ef}")(re.union (re.range "\u{f6}" "\u{f6}")(re.union (re.range "\u{f8}" "\u{f8}") (re.range "\u{fc}" "\u{fc}")))))))))(re.++ (re.range "[" "[") (re.opt (re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e4}" "\u{e4}")(re.union (re.range "\u{e6}" "\u{e6}")(re.union (re.range "\u{eb}" "\u{eb}")(re.union (re.range "\u{ef}" "\u{ef}")(re.union (re.range "\u{f6}" "\u{f6}")(re.union (re.range "\u{f8}" "\u{f8}") (re.range "\u{fc}" "\u{fc}")))))))))(re.++ (re.opt (re.range "[" "["))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e4}" "\u{e4}")(re.union (re.range "\u{e6}" "\u{e6}")(re.union (re.range "\u{eb}" "\u{eb}")(re.union (re.range "\u{ef}" "\u{ef}")(re.union (re.range "\u{f6}" "\u{f6}")(re.union (re.range "\u{f8}" "\u{f8}") (re.range "\u{fc}" "\u{fc}"))))))))) (re.range "[" "["))))))))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "-" "-") ((_ re.loop 1 3) (re.range "0" "9"))))))))) (str.to_re (str.++ "[" (str.++ "\u{5c}" (str.++ "/" (str.++ "b" (str.++ "i" (str.++ "b" (str.++ "l" (str.++ "e" (str.++ "]" "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
