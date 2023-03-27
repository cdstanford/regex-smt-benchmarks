;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '([dmstrl])([ .,?!\)\\/<])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xC\'d)"
(define-fun Witness1 () String (str.++ "\u{0c}" (str.++ "'" (str.++ "d" (str.++ ")" "")))))
;witness2: "\'r<"
(define-fun Witness2 () String (str.++ "'" (str.++ "r" (str.++ "<" ""))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.union (re.range "d" "d")(re.union (re.range "l" "m") (re.range "r" "t"))) (re.union (re.range " " "!")(re.union (re.range ")" ")")(re.union (re.range "," ",")(re.union (re.range "." "/")(re.union (re.range "<" "<")(re.union (re.range "?" "?") (re.range "\u{5c}" "\u{5c}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
