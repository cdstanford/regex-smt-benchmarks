;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (")([0-9]*)(",")([0-9]*)("\))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"3\",\"8\")"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "3" (seq.++ "\x22" (seq.++ "," (seq.++ "\x22" (seq.++ "8" (seq.++ "\x22" (seq.++ ")" "")))))))))
;witness2: "\u00BF\u00CE\x0\"9\",\"988\")"
(define-fun Witness2 () String (seq.++ "\xbf" (seq.++ "\xce" (seq.++ "\x00" (seq.++ "\x22" (seq.++ "9" (seq.++ "\x22" (seq.++ "," (seq.++ "\x22" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "\x22" (seq.++ ")" ""))))))))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.range "0" "9"))(re.++ (str.to_re (seq.++ "\x22" (seq.++ "," (seq.++ "\x22" ""))))(re.++ (re.* (re.range "0" "9")) (str.to_re (seq.++ "\x22" (seq.++ ")" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
