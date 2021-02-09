;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '('{2})*([^'\r\n]*)('{2})*([^'\r\n]*)('{2})*'
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x7\'\'\'\'\'\'\'\x1C\u00BAL\u00EF\'\'\'\'\'a"
(define-fun Witness1 () String (seq.++ "\x07" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "\x1c" (seq.++ "\xba" (seq.++ "L" (seq.++ "\xef" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "a" "")))))))))))))))))))
;witness2: "\'\'\'\'\'6\'\'\'\'\'\u0091<"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "6" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "\x91" (seq.++ "<" ""))))))))))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "&") (re.range "(" "\xff")))))(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "&") (re.range "(" "\xff")))))(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'"))) (re.range "'" "'")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
