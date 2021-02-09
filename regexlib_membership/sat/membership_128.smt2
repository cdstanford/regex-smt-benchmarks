;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '([dmstrl])([ .,?!\)\\/<])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xC\'d)"
(define-fun Witness1 () String (seq.++ "\x0c" (seq.++ "'" (seq.++ "d" (seq.++ ")" "")))))
;witness2: "\'r<"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "r" (seq.++ "<" ""))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.union (re.range "d" "d")(re.union (re.range "l" "m") (re.range "r" "t"))) (re.union (re.range " " "!")(re.union (re.range ")" ")")(re.union (re.range "," ",")(re.union (re.range "." "/")(re.union (re.range "<" "<")(re.union (re.range "?" "?") (re.range "\x5c" "\x5c")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
