;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2})@([a-z0-9]+[.]([a-z]{2,3}|[a-z]{2,3}[.][a-z]{2,3}))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z.99\u00D3.28x8\u00F6@z8.uya.zy\u00EA%"
(define-fun Witness1 () String (str.++ "Z" (str.++ "." (str.++ "9" (str.++ "9" (str.++ "\u{d3}" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "x" (str.++ "8" (str.++ "\u{f6}" (str.++ "@" (str.++ "z" (str.++ "8" (str.++ "." (str.++ "u" (str.++ "y" (str.++ "a" (str.++ "." (str.++ "z" (str.++ "y" (str.++ "\u{ea}" (str.++ "%" ""))))))))))))))))))))))))
;witness2: "\x1Ct9\u00F3\xD8pe8\u008D@89.iyz"
(define-fun Witness2 () String (str.++ "\u{1c}" (str.++ "t" (str.++ "9" (str.++ "\u{f3}" (str.++ "\u{0d}" (str.++ "8" (str.++ "p" (str.++ "e" (str.++ "8" (str.++ "\u{8d}" (str.++ "@" (str.++ "8" (str.++ "9" (str.++ "." (str.++ "i" (str.++ "y" (str.++ "z" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "\u{00}" "-")(re.union (re.range "/" "^") (re.range "`" "\u{ff}"))) ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.union (re.range "\u{00}" "^") (re.range "`" "\u{ff}")))))))(re.++ (re.range "@" "@") (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.range "." ".") (re.union ((_ re.loop 2 3) (re.range "a" "z")) (re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 3) (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
