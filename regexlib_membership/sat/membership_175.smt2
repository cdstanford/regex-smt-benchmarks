;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ('((\\.)|[^\\'])*')
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\'\\u00D2\'b\u007F"
(define-fun Witness1 () String (seq.++ "'" (seq.++ "\x5c" (seq.++ "\xd2" (seq.++ "'" (seq.++ "b" (seq.++ "\x7f" "")))))))
;witness2: "\'\x6\v\'I\u0087"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "\x06" (seq.++ "\x5c" (seq.++ "v" (seq.++ "'" (seq.++ "I" (seq.++ "\x87" ""))))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "\x00" "&")(re.union (re.range "(" "[") (re.range "]" "\xff"))))) (re.range "'" "'")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
