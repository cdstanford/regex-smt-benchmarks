;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http[s]?://([a-zA-Z0-9\-]+\.)*([a-zA-Z]{3,61}|[a-zA-Z]{1,}\.[a-zA-Z]{2})/.*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://-c.-.EUR/\u00F2"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "c" (str.++ "." (str.++ "-" (str.++ "." (str.++ "E" (str.++ "U" (str.++ "R" (str.++ "/" (str.++ "\u{f2}" ""))))))))))))))))))
;witness2: "http://h.at/\u00AE\u00C5:"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "h" (str.++ "." (str.++ "a" (str.++ "t" (str.++ "/" (str.++ "\u{ae}" (str.++ "\u{c5}" (str.++ ":" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.union ((_ re.loop 3 61) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "." ".") ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "/" "/")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
