;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w0-9&#228;&#196;&#246;&#214;&#252;&#220;&#223;\-_]+\.[a-zA-Z0-9]{2,6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ca.f6"
(define-fun Witness1 () String (str.++ "c" (str.++ "a" (str.++ "." (str.++ "f" (str.++ "6" ""))))))
;witness2: "Q\u00BA#.Zx"
(define-fun Witness2 () String (str.++ "Q" (str.++ "\u{ba}" (str.++ "#" (str.++ "." (str.++ "Z" (str.++ "x" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
