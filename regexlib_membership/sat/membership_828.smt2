;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^\d^\-^\,^\x20]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&\u00DB\u00D2\u00FB"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "\xdb" (seq.++ "\xd2" (seq.++ "\xfb" "")))))
;witness2: "=\u008E"
(define-fun Witness2 () String (seq.++ "=" (seq.++ "\x8e" "")))

(assert (= regexA (re.+ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "+")(re.union (re.range "." "/")(re.union (re.range ":" "]") (re.range "_" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
