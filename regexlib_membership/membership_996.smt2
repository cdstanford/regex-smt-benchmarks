;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^_][a-zA-Z0-9_]+[^_]@{1}[a-z]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00DA8\u00AB@fi.xht"
(define-fun Witness1 () String (str.++ "\u{da}" (str.++ "8" (str.++ "\u{ab}" (str.++ "@" (str.++ "f" (str.++ "i" (str.++ "." (str.++ "x" (str.++ "h" (str.++ "t" "")))))))))))
;witness2: "\"4u@y.yxc.etr"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "4" (str.++ "u" (str.++ "@" (str.++ "y" (str.++ "." (str.++ "y" (str.++ "x" (str.++ "c" (str.++ "." (str.++ "e" (str.++ "t" (str.++ "r" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\u{00}" "^") (re.range "`" "\u{ff}"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "\u{00}" "^") (re.range "`" "\u{ff}"))(re.++ (re.range "@" "@")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 3) (re.range "a" "z")) (re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 3) (re.range "a" "z"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
