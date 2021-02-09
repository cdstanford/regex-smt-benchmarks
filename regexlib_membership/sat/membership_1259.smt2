;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<link>((?<prot>http:\/\/)*(?<subdomain>(www|[^\-\n]*)*)(\.)*(?<domain>[^\-\n]+)\.(?<after>[a-zA-Z]{2,3}[^>\n]*)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://http://wwwwwwP.kY\u00F2\u0080"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "P" (seq.++ "." (seq.++ "k" (seq.++ "Y" (seq.++ "\xf2" (seq.++ "\x80" "")))))))))))))))))))))))))))
;witness2: "http://..V\u0084\u00892.hZ\u0091"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "." (seq.++ "." (seq.++ "V" (seq.++ "\x84" (seq.++ "\x89" (seq.++ "2" (seq.++ "." (seq.++ "h" (seq.++ "Z" (seq.++ "\x91" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))))(re.++ (re.* (re.union (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))) (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" ",") (re.range "." "\xff"))))))(re.++ (re.* (re.range "." "."))(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" ",") (re.range "." "\xff"))))(re.++ (re.range "." ".") (re.++ ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "=") (re.range "?" "\xff")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
