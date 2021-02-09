;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\s\S]){1,20}([\s\.])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BA\u00A2 \x0"
(define-fun Witness1 () String (seq.++ "\xba" (seq.++ "\xa2" (seq.++ " " (seq.++ "\x00" "")))))
;witness2: "\u00FB."
(define-fun Witness2 () String (seq.++ "\xfb" (seq.++ "." "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 20) (re.range "\x00" "\xff")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "." ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
