;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<link>((?<prot>http:\/\/)*(?<subdomain>(www|[^\-\n]*)*)(\.)*(?<domain>[^\-\n]+)\.(?<after>[a-zA-Z]{2,3}[^>\n]*)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://http://wwwwwwP.kY\u00F2\u0080"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "P" (str.++ "." (str.++ "k" (str.++ "Y" (str.++ "\u{f2}" (str.++ "\u{80}" "")))))))))))))))))))))))))))
;witness2: "http://..V\u0084\u00892.hZ\u0091"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "." (str.++ "." (str.++ "V" (str.++ "\u{84}" (str.++ "\u{89}" (str.++ "2" (str.++ "." (str.++ "h" (str.++ "Z" (str.++ "\u{91}" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))))(re.++ (re.* (re.union (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" ",") (re.range "." "\u{ff}"))))))(re.++ (re.* (re.range "." "."))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" ",") (re.range "." "\u{ff}"))))(re.++ (re.range "." ".") (re.++ ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "=") (re.range "?" "\u{ff}")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
