;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[bible[=]?([a-zäëïöüæø]*)\]((([0-9][[:space:]]?)?[a-zäëïöüæø]*[[:space:]]{1}([a-zäëïöüæø]*[[:space:]]?[a-zäëïöüæø]*[[:space:]]{1})?)([0-9]{1,3})(:{1}([0-9]{1,3})(-{1}([0-9]{1,3}))?)?)\[\\/bible\]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "%[bible=\u00F6\u00E4]\u00EB\u00F6l[9[\/bible]\u00A0\\u00E3\u00A1"
(define-fun Witness1 () String (seq.++ "%" (seq.++ "[" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "=" (seq.++ "\xf6" (seq.++ "\xe4" (seq.++ "]" (seq.++ "\xeb" (seq.++ "\xf6" (seq.++ "l" (seq.++ "[" (seq.++ "9" (seq.++ "[" (seq.++ "\x5c" (seq.++ "/" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "]" (seq.++ "\xa0" (seq.++ "\x5c" (seq.++ "\xe3" (seq.++ "\xa1" ""))))))))))))))))))))))))))))))
;witness2: "\u00E0[bible]4[wtv[9[\/bible]*"
(define-fun Witness2 () String (seq.++ "\xe0" (seq.++ "[" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "]" (seq.++ "4" (seq.++ "[" (seq.++ "w" (seq.++ "t" (seq.++ "v" (seq.++ "[" (seq.++ "9" (seq.++ "[" (seq.++ "\x5c" (seq.++ "/" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "]" (seq.++ "*" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "[" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" "")))))))(re.++ (re.opt (re.range "=" "="))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe4" "\xe4")(re.union (re.range "\xe6" "\xe6")(re.union (re.range "\xeb" "\xeb")(re.union (re.range "\xef" "\xef")(re.union (re.range "\xf6" "\xf6")(re.union (re.range "\xf8" "\xf8") (re.range "\xfc" "\xfc")))))))))(re.++ (re.range "]" "]")(re.++ (re.++ (re.++ (re.opt (re.++ (re.range "0" "9") (re.opt (re.range "[" "["))))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe4" "\xe4")(re.union (re.range "\xe6" "\xe6")(re.union (re.range "\xeb" "\xeb")(re.union (re.range "\xef" "\xef")(re.union (re.range "\xf6" "\xf6")(re.union (re.range "\xf8" "\xf8") (re.range "\xfc" "\xfc")))))))))(re.++ (re.range "[" "[") (re.opt (re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe4" "\xe4")(re.union (re.range "\xe6" "\xe6")(re.union (re.range "\xeb" "\xeb")(re.union (re.range "\xef" "\xef")(re.union (re.range "\xf6" "\xf6")(re.union (re.range "\xf8" "\xf8") (re.range "\xfc" "\xfc")))))))))(re.++ (re.opt (re.range "[" "["))(re.++ (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe4" "\xe4")(re.union (re.range "\xe6" "\xe6")(re.union (re.range "\xeb" "\xeb")(re.union (re.range "\xef" "\xef")(re.union (re.range "\xf6" "\xf6")(re.union (re.range "\xf8" "\xf8") (re.range "\xfc" "\xfc"))))))))) (re.range "[" "["))))))))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (re.range "-" "-") ((_ re.loop 1 3) (re.range "0" "9"))))))))) (str.to_re (seq.++ "[" (seq.++ "\x5c" (seq.++ "/" (seq.++ "b" (seq.++ "i" (seq.++ "b" (seq.++ "l" (seq.++ "e" (seq.++ "]" "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
