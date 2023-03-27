;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^/{1}(((/{1}\.{1})?[a-zA-Z0-9 ]+/?)+(\.{1}[a-zA-Z0-9]{2,4})?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "//.KVw/V/. Y"
(define-fun Witness1 () String (str.++ "/" (str.++ "/" (str.++ "." (str.++ "K" (str.++ "V" (str.++ "w" (str.++ "/" (str.++ "V" (str.++ "/" (str.++ "." (str.++ " " (str.++ "Y" "")))))))))))))
;witness2: "/t /.5ut"
(define-fun Witness2 () String (str.++ "/" (str.++ "t" (str.++ " " (str.++ "/" (str.++ "." (str.++ "5" (str.++ "u" (str.++ "t" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "/" "/")(re.++ (re.++ (re.+ (re.++ (re.opt (str.to_re (str.++ "/" (str.++ "." ""))))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.range "/" "/"))))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
