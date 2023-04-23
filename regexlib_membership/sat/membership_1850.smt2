;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://a.FZK"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "a" (str.++ "." (str.++ "F" (str.++ "Z" (str.++ "K" "")))))))))))))
;witness2: "http://H..YZ"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "H" (str.++ "." (str.++ "." (str.++ "Y" (str.++ "Z" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
