;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "((\\")|[^"(\\")])+"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C1\'\"\u00AC\"\u008C"
(define-fun Witness1 () String (seq.++ "\xc1" (seq.++ "'" (seq.++ "\x22" (seq.++ "\xac" (seq.++ "\x22" (seq.++ "\x8c" "")))))))
;witness2: "ywH.PI\u00F9\u00A3\"\\"\""
(define-fun Witness2 () String (seq.++ "y" (seq.++ "w" (seq.++ "H" (seq.++ "." (seq.++ "P" (seq.++ "I" (seq.++ "\xf9" (seq.++ "\xa3" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "\x22" (seq.++ "\x22" "")))))))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (str.to_re (seq.++ "\x5c" (seq.++ "\x22" ""))) (re.union (re.range "\x00" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "[") (re.range "]" "\xff")))))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
